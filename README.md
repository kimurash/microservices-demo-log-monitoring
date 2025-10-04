# microservice-demo

これは [microservice-demo](https://github.com/GoogleCloudPlatform/microservices-demo) を改造したリポジトリです。

## 環境構築

### EKS クラスターの構築

```bash
cd eksctl
eksctl create cluster -f cluster-config.yaml
```

### Terraform モジュールのデプロイ

- `terraform/` 以下の `gcp` 以外のモジュールを `apply` する
- 各モジュール内に `terraform.tfvars` を作る
- `variables.tf` の値を `terraform.tfvars` に記述する

```bash
cd terraform/<module_name>
terraform apply
```

## 環境破壊

### Terraform モジュールの破壊

```bash
cd terraform/<module_name>
tf destroy
```

### EKS クラスターの破壊

```bash
cd eksctl
eksctl delete cluster -f cluster-config.yaml --disable-nodegroup-eviction
```
