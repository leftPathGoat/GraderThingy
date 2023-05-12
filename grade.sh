CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ ! -f "student-submission/ListExamples.java" ]]
then
    echo "ListExamples.java not found"
    exit 1
fi

cp -r student-submission/*.java grading-area
cp TestListExamples.java grading-area
if [[ $? -ne 0 ]]
then
    echo "Failed to copy files"
    exit 1
fi

javac -cp $CPATH grading-area/*.java 2> grading-area/error.txt
if [[ $? -ne 0 ]]
then
    echo "Failed to compile, check grading-area/error.txt for details"
    exit 1
fi

java -cp $CPATH:grading-area org.junit.runner.JUnitCore TestListExamples > grading-area/error.txt
if [[ $? == 0 ]]
then
    echo "Tests passed"
    exit 0
else
    echo "Tests failed, check grading-area/error.txt for details"
    exit 1
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
