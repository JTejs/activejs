#cd to extensions/docs dir, then run:
#./make_docs.sh ~/Documents/workspace/com.aptana.sdoc
# or whatever your com.aptana.sdoc location is

cd ..
cd website

echo Building documentation XML file
rm -rf docs
mkdir docs
java -jar $1/libs/AptanaDocGen.jar \
	--filter-private \
	--show-warnings \
	--import Jaxer.=JSLib. \
	--output-file ./docs/docs.xml \
	./dist/active.js \

echo Building HTML from XML
cp $1/libs/*.gif ./docs
cp $1/libs/*.png ./docs
cp $1/libs/*.js ./docs
cp $1/libs/*.css ./docs

cp extensions/docs/sh.css ./docs/sh.css
cp extensions/docs/sh_javascript.js ./docs/sh_javascript.js
cp extensions/docs/sh_main.js ./docs/sh_main.js
cp extensions/docs/showdown.js ./docs/showdown.js

cd docs
java -jar $1/libs/saxon8.jar \
    ./docs.xml \
	$1/libs/help_documentation.xslt \
	ReferenceName=ActiveJS \
	ClassExampleAtTop=true \
	ReferenceDisplayName="ActiveJS" \
	ClassHeaderFragment=$PWD/../extensions/docs/fragment.xml
	
cp ActiveJS.index-frame.html index.html
cd ..
echo Documentation generation complete
cd docs