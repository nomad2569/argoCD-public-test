# Resource: Helm Release 
resource "helm_release" "external_dns" {
  depends_on = [aws_iam_role.externaldns_iam_role]            
  name       = "external-dns"

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"

  namespace = "default"     

  set {
    name = "image.repository"
    # https://musma.github.io/2023/03/29/k8s-issue-solution.html
    # 2023년 4월 3일부터 쿠버네티스 프로젝트의 레지스트리가 
    # 기존 k8s.gcr.io 레지스트리에서 새로운 레지스트리인 registry.k8s.io 레지스트리로 변경됨에 따라 k8s.gcr.io 레지스트리를 참조하는 이미지에 대한
    # 지원이 중단되었습니다. 
    value = "registry.k8s.io/external-dns/external-dns" 
  }       

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.externaldns_iam_role.arn}"
  }

  set {
    name  = "provider" # Default is aws (https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns)
    value = "aws"
  }    

  set {
    name  = "policy" # Default is "upsert-only" which means DNS records will not get deleted even equivalent Ingress resources are deleted (https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns)
    value = "sync"   # "sync" will ensure that when ingress resource is deleted, equivalent DNS record in Route53 will get deleted
  }    
        
}
