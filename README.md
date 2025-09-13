# 监控系统概览

本监控系统基于 Helm 部署，整合了 Prometheus Operator 与自定义 Exporter，支持核心集群指标采集、告警推送与多渠道通知。

## 监控范围
- **Kubernetes 系统组件**：apiserver / scheduler / controller-manager / etcd / kubelet / coredns
- **节点与基础设施**：Node Exporter（CPU / 内存 / 磁盘 / 网络 / IB / RoCE）、IPMI Exporter（硬件健康）
- **存储与中间件**：Ceph / RBD / S3、Postgres Exporter、Harbor Exporter
- **网络与容器**：Calico Felix、Ingress Nginx
- **GPU 监控**：NVIDIA DCGM Exporter、国产 GPU Exporter
- **调度与批任务**：Volcano Scheduler
- **应用级监控**：Kafka / Minio / 自定义组件

## 告警方式
- **飞书群组**：按告警等级 P0–P3 分组通知
- **飞书表格**：告警新增/恢复自动归档
- **飞书电话**：P0 关键告警实时电话通知
- **周报**：支持每周定时生成告警统计周报

## 部署方式
在仓库根目录执行安装脚本即可创建命名空间、注入额外配置、部署 `kube-prometheus-stack` 并应用扩展的 ServiceMonitor 与 PrometheusRule：

```bash
./install.sh
```

## 使用方式
- **统一入口**：通过 `values.yaml` 控制系统组件采集的开关
- **扩展子 Chart**：GPU、Harbor、Postgres、Volcano 等监控逻辑归入独立子 Chart，便于启用或禁用
- **告警管理**：所有规则通过 `PrometheusRule` 管理，支持覆盖默认规则
