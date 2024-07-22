{{/*
Expand the name of the chart.
*/}}
{{- define "kinetica-operators.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kinetica-operators.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kinetica-operators.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kinetica-operators.labels" -}}
helm.sh/chart: {{ include "kinetica-operators.chart" . }}
{{ include "kinetica-operators.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kinetica-operators.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kinetica-operators.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kinetica-operators.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kinetica-operators.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "kinetica-operators.db.image" }}
    {{- with . }}
        {{- $rep := .repository -}}
        {{- $tag := .tag -}}
        {{- $registry := "docker.io" -}}
        {{- $repository := $rep -}}
        {{- $registryList := splitList "/" $rep -}}
        {{- if ge (len $registryList) 2 }}
            {{- $registryPieces := splitList "." (index $registryList 0) -}}
            {{- if gt (len $registryPieces) 1 }}
                {{- $registry = index $registryList 0 -}}
                {{- $repository = join "/" (slice $registryList 1) -}}
            {{ end -}}
        {{ end -}}

registry: "{{ $registry }}"
repository: "{{ $repository }}"
tag: "{{ $tag }}"
    {{ end -}}
{{ end -}}


