#!/bin/sh

# Define vars
NC='\033[0m'
RED='\033[0;31m'
BLUE='\e[36m'
YELLOW='\033[0;33m'
EXIT_CODE=0

# Clean coverage related files
rm -rf /app/.coverage
rm -rf /app/coverage.log
rm -rf /app/htmlcov
rm -rf /tmp/test.log

printf "${YELLOW}Testing Started${NC}\n"

# Run tests via test coverage
coverage erase
coverage run /app/manage.py test > /tmp/test.log 2>&1
coverage report 2>&1 | tee coverage.log
coverage html
coverage xml

# Check if unit tests failed!
TEST_RESULT=$(cat /tmp/test.log  | grep -o 'FAILED')
if [ $TEST_RESULT ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test $TEST_RESULT!${NC}\n"
    printf "${BLUE}"
    cat /tmp/test.log
    printf "${NC}"
    EXIT_CODE=1
fi

# Check if test coverage is high enough
EXPECTED_COVERAGE=$(coverage report | tail -n1 | cut -d"=" -f 2)
RETURNED_COVERAGE=$(coverage report | tail -n1 | cut -d' ' -f 5)
COVERAGE_RESULT=$(coverage report | tail -n1 | awk '{print $2}' | head -c 7)
if [ "$COVERAGE_RESULT" = "failure" ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test coverage $RETURNED_COVERAGE is smaller than expected coverage ($EXPECTED_COVERAGE)${NC}\n"
    EXIT_CODE=1
fi

# Clean coverage related files
rm -rf /app/.coverage
rm -rf /app/coverage.log
rm -rf /app/htmlcov
rm -rf /tmp/test.log

printf "${YELLOW}Testing Ended${NC}\n"

exit $EXIT_CODE