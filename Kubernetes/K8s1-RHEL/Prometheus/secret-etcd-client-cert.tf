resource "kubernetes_secret" "etcd" {

  type = "Opaque"

  metadata {
    name      = "etcd-client-cert"
    namespace = "prometheus"
  }

  # cat /etc/kubernetes/pki/etcd/ca.crt
  # cat /etc/kubernetes/pki/apiserver-etcd-client.crt
  # cat /etc/kubernetes/pki/apiserver-etcd-client.key
  data = {
    "ca.crt"     = filebase64(".certs/ca.crt")
    "client.crt" = filebase64(".certs/apiserver-etcd-client.crt")
    "client.key" = filebase64(".certs/apiserver-etcd-client.key")
  }

}
