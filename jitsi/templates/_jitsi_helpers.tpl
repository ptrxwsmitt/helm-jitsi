{{/*
domain
*/}}
{{- define "jitsi.XMPP_DOMAIN" -}}
{{- .Values.jitsi.xmppDomain }}
{{- end }}

{{/*
auth-domain
*/}}
{{- define "jitsi.XMPP_AUTH_DOMAIN" -}}
{{- printf "auth.%s" .Values.jitsi.xmppDomain }}
{{- end }}

{{/*
Muc-domain
*/}}
{{- define "jitsi.XMPP_MUC_DOMAIN" -}}
{{- printf "muc.%s" .Values.jitsi.xmppDomain }}
{{- end }}

{{/*
InternalMuc-domain
*/}}
{{- define "jitsi.XMPP_INTERNAL_MUC_DOMAIN" -}}
{{- printf "internal-muc.%s" .Values.jitsi.xmppDomain }}
{{- end }}

