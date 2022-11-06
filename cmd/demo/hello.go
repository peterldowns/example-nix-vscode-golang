//nolint:gochecknoglobals
package main

import (
	"fmt"

	"github.com/spf13/cobra"

	"github.com/peterldowns/jumppointsearch/pkg/demo"
)

var helloFlags = struct {
	Name *string
}{}

var helloCmd = &cobra.Command{
	Use: "hello",
	Run: func(_ *cobra.Command, _ []string) {
		fmt.Println(demo.Hello(*helloFlags.Name))
	},
}

//nolint:gochecknoinits
func init() {
	helloFlags.Name = helloCmd.Flags().String("name", "", "name of now")
	_ = helloCmd.MarkFlagRequired("name")
	root.AddCommand(helloCmd)
}
