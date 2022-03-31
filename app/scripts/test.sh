#!/bin/sh

# Define vars
NC='\033[0m'
RED='\033[0;31m'
BLUE='\e[36m'
YELLOW='\033[0;33m'
EXIT_CODE=0
COVERAGE_DIR=/tmp/coverage

# Global vars
export COVERAGE_FILE=/tmp/coverage/.coverage

# SetUp file system
mkdir -p $COVERAGE_DIR
rm -rf $COVERAGE_DIR/*

# Run tests via test coverage
coverage run -m pytest -p no:cacheprovider > $COVERAGE_DIR/pytest.out 2>&1
coverage report 2>&1 | tee $COVERAGE_DIR/report.out
coverage html --data-file=$COVERAGE_DIR/.coverage --directory=$COVERAGE_DIR/htmlcov
coverage xml --data-file=$COVERAGE_DIR/.coverage -o $COVERAGE_DIR/coverage.xml

# Check if unit tests failed!
TEST_RESULT=$(cat $COVERAGE_DIR/pytest.out  | grep -o 'FAILED')
if [ $TEST_RESULT ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test $TEST_RESULT!${NC}\n"
    printf "${BLUE}"
    cat $COVERAGE_DIR/pytest.out
    printf "${NC}"
    EXIT_CODE=1
fi

# Check if test coverage is high enough
EXPECTED_COVERAGE=$(cat $COVERAGE_DIR/report.out | tail -n1 | cut -d"=" -f 2)
RETURNED_COVERAGE=$(cat $COVERAGE_DIR/report.out | tail -n1 | cut -d' ' -f 5)
COVERAGE_RESULT=$(cat $COVERAGE_DIR/report.out | tail -n1 | awk '{print $2}' | head -c 7)
if [ "$COVERAGE_RESULT" = "failure" ]; then
    printf "${RED}ERROR:${NC} ${YELLOW}Test coverage result $RETURNED_COVERAGE percent is smaller than expected coverage score $EXPECTED_COVERAGE percent${NC}\n"
    EXIT_CODE=1
fi

exit $EXIT_CODE