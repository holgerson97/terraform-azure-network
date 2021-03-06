package test

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var terraExamples, _ = filepath.Abs("../examples/")

func TestInitAndApplyAndIdempotent(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: terraExamples,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApplyAndIdempotentE(t, terraformOptions)

}

func TestAzureResourcesRequired(t *testing.T) {

	subscriptionID := os.Getenv("TF_VAR_ARM_SUBSCRIPTION_ID")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: terraExamples,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	virtualNetworkName := terraform.Output(t, terraformOptions, "virtual_network_name")
	dnsServersIp := terraform.OutputList(t, terraformOptions, "dns_servers_ip")
	subnetAddressPrefixes := terraform.OutputList(t, terraformOptions, "subnet_address_prefixes")

	t.Run("RG", func(t *testing.T) {

		exists := azure.ResourceGroupExists(t, resourceGroupName, subscriptionID)
		assert.True(t, exists, "Resource group does not exist.")

	})
	t.Run("VNET", func(t *testing.T) {

		exists := azure.VirtualNetworkExists(t, virtualNetworkName, resourceGroupName, subscriptionID)
		assert.True(t, exists, "Virtual Network does note exist.")

	})

	t.Run("DNS_Servers", func(t *testing.T) {

		exists := azure.GetVirtualNetworkDNSServerIPs(t, virtualNetworkName, resourceGroupName, subscriptionID)
		assert.Equal(t, exists, dnsServersIp, "DNS servers IP are not in desired state.")

	})
	t.Run("Subnets", func(t *testing.T) {

		refactoredOutput := []string{}
		for _, value := range subnetAddressPrefixes {

			if value[0] == '[' {
				value = value[1:]
			}

			if last := len(value) - 1; last >= 0 && value[last] == ']' {
				value = value[:last]
			}

			refactoredOutput = append(refactoredOutput, value)

		}

		exists := azure.GetVirtualNetworkSubnets(t, virtualNetworkName, resourceGroupName, subscriptionID)
		subnets := []string{}
		for _, value := range exists {

			subnets = append(subnets, value)

		}

		assert.Equal(t, refactoredOutput, subnets, "Subnet address prefixes are not in desired state.")

	})
}