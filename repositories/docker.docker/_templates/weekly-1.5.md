{{/*
*/}}{{ define "closed_at" }}{{ .closed_at | one | formatDate }}{{ end }}{{/*
*/}}{{ define "item_lnk"  }}{{ with $n := one .number }}{{ printf "[#%.0f](https://github.com/docker/docker/issues/%.0f)" $n $n }}{{ end }}{{ end }}{{/*
*/}}{{ define "fmt_login" }}{{ printf "[%s](https://github.com/%s)" . . }}{{ end }}{{/*
*/}}{{ define "login_lnk" }}{{ with $l := index . "author.login" | one }}{{ template "fmt_login" . }}{{ end }}{{ end }}{{/*

*/}}This week on the [Docker Engine](https://github.com/docker/docker):
{{/*

*/}}{{ with search "engine-snapshot" "submitted.json" }}
  - **{{ .Hits.Total }} pull requests** were submitted by **{{ .Aggregations.unique_authors.value }} unique contributors**.{{ end }}{{/*
*/}}{{ with search "engine-snapshot" "closed.json" }}
  - **{{ .Hits.Total }} pull requests** were processed ({{ .Aggregations.is_merged.buckets.merged.doc_count }} of those were merged).{{ end }}
{{/*

*/}}
These are the most notable items merged (as indicated by the `impact/changelog` label):

  Merged at | Author                                  | Number                                                 | Title
  ----------|-----------------------------------------|--------------------------------------------------------|--------------------------------------------------------------
{{ with $changelog := search "engine-snapshot" "changelog.json" }}{{ range $changelog.Hits.Hits }}{{ with map .Fields }}  {{ template "closed_at" . }} | {{ template "login_lnk" . }} | {{ template "item_lnk" . }} | {{ one .title }}{{ end }}
{{ end }}{{ end }}
{{/*

*/}}In the community:
{{ with search "engine-snapshot" "merged.json" }}
  - Congratulations{{ range .Aggregations.is_maintainer.buckets.non_maintainer.logins.buckets }} **{{ template "fmt_login" .key }}** ({{ .doc_count }}),{{ end }} for your pull requests getting merged, and thank you for the contributions!{{/*
*/}}{{ with $b := .Aggregations.is_maintainer.buckets.maintainer.logins.buckets }}{{ if $b }}
  - {{ with index $b 0 }}**{{ template "fmt_login" .key }}** was the most effective maintainer with {{ .doc_count }} pull requests merged{{ end }}.{{/*
*/}}{{ end }}{{ end }}{{/*
*/}}{{ with $b := .Aggregations.closed_by.buckets }}{{ if $b }}
  - Maintainers {{ range $b }}**{{ template "fmt_login" .key }}** ({{ .doc_count }}), {{ end }}spread some love with their merges!{{/*
*/}}{{ end }}{{ end }}{{/*
*/}}{{ with (search "engine-live*" "dream_killer.json").Aggregations.login.buckets }}{{ if . }}{{ with index . 0 }}
  - This week top dream killer is **{{ template "fmt_login" .key }}** with {{ .doc_count }} pull requests closed.{{/*
*/}}{{ end }}{{ end }}{{ end }}
{{ end }}
