## - Template for add all hardcode manifests in manifests directory
{{ range $path, $_ :=  .Files.Glob  "manifests/**.yaml" }}
---
# Source: {{ $path }}
{{ $.Files.Get $path }}
{{ end }}
