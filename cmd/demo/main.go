//nolint:gochecknoglobals
package main

import (
	"github.com/spf13/cobra"
)

var root = &cobra.Command{
	Use:              "demo",
	Short:            "simple cobra example",
	TraverseChildren: true,
}

func main() {
	// Disable the builtin shell-completion script generator command
	root.CompletionOptions.DisableDefaultCmd = true

	if err := root.Execute(); err != nil {
		panic(err)
	}
}
