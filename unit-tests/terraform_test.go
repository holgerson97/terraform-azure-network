package test

import (
	"testing"
	
	"github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestInitAndApplyAndIdempotent(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "/home/nilscarstensen/repositorys/terraform-azure-network",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApplyAndIdempotentE(t, terraformOptions)

}

func TestAzureResources(t *testing.T) {

	subscriptionID := ""

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "/home/nilscarstensen/repositorys/terraform-azure-network",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	
	t.Run("RG", func(t *testing.T) {

		resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")

		exists := azure.ResourceGroupExists(t, resourceGroupName, subscriptionID)
		assert.True(t, exists, "Resource group does not exist")

	})
}