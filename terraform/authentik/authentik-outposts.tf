# SillyTavern outpost using existing service connection
resource "authentik_outpost" "sillytavern" {
  name                 = "SillyTavern Outpost"
  type                 = "proxy"
  service_connection   = data.authentik_service_connection_kubernetes.local.id
  protocol_providers   = [authentik_provider_proxy.sillytavern_proxy.id]
  
  config = jsonencode({
    authentik_host                = var.authentik_url
    authentik_host_insecure       = false
    authentik_host_browser        = ""
    log_level                     = "debug"
    object_naming_template        = "ak-outpost-%(name)s"
    docker_network                = null
    docker_map_ports              = true
    kubernetes_replicas           = 1
    kubernetes_namespace          = "apps"
    kubernetes_ingress_annotations = {
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTP"
      "nginx.ingress.kubernetes.io/proxy-buffers-number" = "8"
      "nginx.ingress.kubernetes.io/proxy-buffer-size" = "32k"
      "nginx.ingress.kubernetes.io/configuration-snippet" = <<-EOT
        auth_request_set $authentik_username $upstream_http_x_authentik_username;
        auth_request_set $authentik_groups $upstream_http_x_authentik_groups;
        auth_request_set $authentik_email $upstream_http_x_authentik_email;
        auth_request_set $authentik_name $upstream_http_x_authentik_name;
        auth_request_set $authentik_uid $upstream_http_x_authentik_uid;
        auth_request_set $remote_user $upstream_http_remote_user;
        proxy_set_header X-authentik-username $authentik_username;
        proxy_set_header X-authentik-groups $authentik_groups;
        proxy_set_header X-authentik-email $authentik_email;
        proxy_set_header X-authentik-name $authentik_name;
        proxy_set_header X-authentik-uid $authentik_uid;
        proxy_set_header Remote-User $remote_user;
      EOT
    }
    kubernetes_ingress_secret_name = "st-test-home-ryougi-ca-tls"
    kubernetes_ingress_class_name  = "nginx"
    kubernetes_service_type        = "ClusterIP"
    kubernetes_disabled_components = []
    kubernetes_image_pull_secrets  = []
  })
}