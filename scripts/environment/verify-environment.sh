#!/bin/bash

echo "=== DevOps开发环境验证 ==="
echo

# 检查操作系统
echo "📋 操作系统信息:"
cat /etc/os-release | grep PRETTY_NAME
echo

# 检查基础工具
echo "🔧 基础工具检查:"
tools=("git" "curl" "wget" "vim" "docker" "docker-compose" "node" "java")

for tool in "${tools[@]}"; do
    if command -v $tool &> /dev/null; then
        version=$(${tool} --version 2>/dev/null | head -n 1 || echo "已安装")
        echo "✅ $tool: $version"
    else
        echo "❌ $tool: 未安装"
    fi
done

echo
echo "🐳 Docker服务状态:"
if systemctl is-active --quiet docker; then
    echo "✅ Docker服务运行中"
    docker run --rm hello-world 2>/dev/null && echo "✅ Docker容器测试成功" || echo "❌ Docker容器测试失败"
else
    echo "❌ Docker服务未运行"
fi

echo
echo "📁 推荐的目录结构:"
mkdir -p ~/devops-workspace/{projects,scripts,configs,docs}
tree ~/devops-workspace/ 2>/dev/null || ls -la ~/devops-workspace/

echo
echo "=== 验证完成 ==="