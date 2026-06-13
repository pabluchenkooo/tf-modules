# Traefik v3 via Helm, with an HTTP-01 Let's Encrypt cert resolver named
# "letsencrypt". IngressRoutes / Ingresses reference it via the certresolver.
# acme.json is persisted on a small PVC; fsGroup makes it writable by the
# non-root traefik user (uid/gid 65532).

resource "helm_release" "traefik" {
  name             = "traefik"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = var.chart_version

  values = [yamlencode({
    logs = {
      general = { level = var.log_level }
    }

    # Watch both standard Ingress objects and Traefik's own IngressRoute CRD.
    providers = {
      kubernetesIngress = { enabled = true }
      kubernetesCRD     = { enabled = true }
    }

    # Single replica required for the file-based ACME store.
    deployment = {
      replicas = 1
    }

    # Persist acme.json across restarts.
    persistence = {
      enabled    = true
      name       = "data"
      accessMode = "ReadWriteOnce"
      size       = "128Mi"
      path       = "/data"
    }

    # Make the ACME store writable by the non-root traefik user.
    podSecurityContext = {
      fsGroup             = 65532
      fsGroupChangePolicy = "OnRootMismatch"
    }

    additionalArguments = [
      "--certificatesresolvers.letsencrypt.acme.email=${var.letsencrypt_email}",
      "--certificatesresolvers.letsencrypt.acme.storage=/data/acme.json",
      "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=web",
    ]
  })]
}
