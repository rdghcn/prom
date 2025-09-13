#!/usr/bin/env bash
set -euo pipefail

# Create monitoring namespace
kubectl apply -f namespace.yaml

# Inject additional scrape configurations
kubectl apply -f additional-scrapeconfigs.yaml -n monitoring

# Deploy kube-prometheus-stack chart from local directory
helm upgrade --install prom kube-prometheus-stack -n monitoring

# Apply extra ServiceMonitor and PrometheusRule resources
kubectl apply -f servicemonitors/ -n monitoring
kubectl apply -f promrules/ -n monitoring
