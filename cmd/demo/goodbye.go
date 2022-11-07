//nolint:gochecknoglobals
package main

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"

	"github.com/peterldowns/jumppointsearch/pkg/demo"
)

var goodbyeCmd = &cobra.Command{
	Use:  "goodbye",
	Args: cobra.ArbitraryArgs,
	Run: func(_ *cobra.Command, args []string) {
		fmt.Println(demo.Goodbye(strings.Join(args, " ")))
	},
}

//nolint:gochecknoinits
func init() {
	root.AddCommand(goodbyeCmd)
}
