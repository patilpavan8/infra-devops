{{- define "lamp-catalog.name" -}}
lamp-catalog
{{- end }}

{{- define "lamp-catalog.fullname" -}}
{{ .Release.Name }}-lamp
{{- end }}
