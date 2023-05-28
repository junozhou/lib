https://help.aliyun.com/document_detail/440253.html



存活探针
对于每个container都配置了存活探针（spec.containers[].livenessProbe）

# Source: mysql-operator/templates/deployment.yaml
apiVersion: apps/v1
spec:
  replicas: 1
  template:
    spec:
      containers:
        - name: mysql-operator
          securityContext:
            {}
          image: "harbor.middleware.com/middleware/mysql-operator:v1.0.18"
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            failureThreshold: 3
            httpGet:
              path: /healthz
              port: 10880
              scheme: HTTP
            initialDelaySeconds: 5
            periodSeconds: 5
            successThreshold: 1
            timeoutSeconds: 5