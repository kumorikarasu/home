{{/*
Helper to generate the static name for the GitHub App secret.
*/}}
{{- define "github-runner.appSecretName" -}}
{{- printf "github-runner-app-credentials" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "github-runner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "github-runner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
