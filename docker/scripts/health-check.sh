#!/bin/bash
# Neurite Health Check Script
# Comprehensive health monitoring for Docker services

set -e

# Configuration
FRONTEND_URL="http://localhost:8080"
BACKEND_URL="http://localhost:7070"
TIMEOUT=10

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Health check functions
check_frontend() {
    echo -n "Checking frontend service... "
    if curl -f -s --max-time $TIMEOUT "$FRONTEND_URL" > /dev/null; then
        echo -e "${GREEN}✓ OK${NC}"
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        return 1
    fi
}

check_backend() {
    echo -n "Checking backend service... "
    if curl -f -s --max-time $TIMEOUT "$BACKEND_URL/check" > /dev/null; then
        echo -e "${GREEN}✓ OK${NC}"
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        return 1
    fi
}

check_database() {
    echo -n "Checking database... "
    if [ -f "/app/data/neurite.db" ]; then
        echo -e "${GREEN}✓ OK${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠ WARNING: Database file not found${NC}"
        return 1
    fi
}

check_disk_space() {
    echo -n "Checking disk space... "
    USAGE=$(df /app | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$USAGE" -lt 90 ]; then
        echo -e "${GREEN}✓ OK (${USAGE}% used)${NC}"
        return 0
    else
        echo -e "${RED}✗ CRITICAL (${USAGE}% used)${NC}"
        return 1
    fi
}

check_memory() {
    echo -n "Checking memory... "
    MEMORY_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100.0}')
    if [ "$MEMORY_USAGE" -lt 90 ]; then
        echo -e "${GREEN}✓ OK (${MEMORY_USAGE}% used)${NC}"
        return 0
    else
        echo -e "${RED}✗ CRITICAL (${MEMORY_USAGE}% used)${NC}"
        return 1
    fi
}

# Main health check
main() {
    echo "=== Neurite Health Check ==="
    echo "Timestamp: $(date)"
    echo ""

    # Initialize counters
    CHECKS_PASSED=0
    TOTAL_CHECKS=5

    # Run health checks
    check_frontend && ((CHECKS_PASSED++))
    check_backend && ((CHECKS_PASSED++))
    check_database && ((CHECKS_PASSED++))
    check_disk_space && ((CHECKS_PASSED++))
    check_memory && ((CHECKS_PASSED++))

    echo ""
    echo "=== Health Check Summary ==="
    echo "Passed: $CHECKS_PASSED/$TOTAL_CHECKS"

    if [ "$CHECKS_PASSED" -eq "$TOTAL_CHECKS" ]; then
        echo -e "${GREEN}✓ All systems healthy${NC}"
        exit 0
    elif [ "$CHECKS_PASSED" -ge 3 ]; then
        echo -e "${YELLOW}⚠ Some issues detected${NC}"
        exit 1
    else
        echo -e "${RED}✗ Critical issues detected${NC}"
        exit 2
    fi
}

# Run main function
main "$@"
