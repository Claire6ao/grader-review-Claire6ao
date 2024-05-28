CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

#step 1 -- clone the student's repository
git clone $1 student-submission
echo 'Finished cloning'

#step 2 -- Check that the student code has the correct file submitted
if [[ -f student-submission/ListExamples.java ]]; then
    echo "ListExample.java exists"
else
    echo "ListExample.java does not exist"
    echo "Grade 0"
fi

#step3 -- Put all relevant files in the directory
cp student-submission/ListExamples.java TestListExamples.java grading-area

cp -r lib grading-area

#step4 -- Compile your tests and the student's code from the directory
cd grading-area
javac -cp $CPATH ListExamples.java TestListExamples.java

echo "The exist code for javac is $?"

#step5 -- Run the tests and report the grade based on the JUnit output
echo "runing Junit tests..."
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit_output.txt 

# Check if JUnit tests passed or failed
if grep -q "FAILURES!!!" junit_output.txt; then
    echo "test fails"
else 
    echo "all tests passes"
fi

#display the detailed output
echo "JUnit test output:"
cat junit_output.txt

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

