//nolint:gochecknoglobals
package main

import (
	"fmt"

	"github.com/spf13/cobra"

	"github.com/peterldowns/jumppointsearch/pkg/demo"
)

var nowCmd = &cobra.Command{
	Use: "now",
	Run: func(_ *cobra.Command, _ []string) {
		fmt.Println(demo.Now())
	},
}

//nolint:gochecknoinits
func init() {
	root.AddCommand(nowCmd)
}
