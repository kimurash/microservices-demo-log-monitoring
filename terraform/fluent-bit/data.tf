data "kubectl_path_documents" "fluent_bit_documents" {
  pattern          = "./manifests/fluent-bit/fluent-bit.yaml"
  disable_template = true
}
