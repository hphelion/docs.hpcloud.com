# We have moved!

Please note if you are still using the old repository at `https://git.hpcloud.net/API-Specs/apihome` then, you will need 
to update your local git repository's remote url to the new url. 

The command to do that is:

`git remote set-url <name> <newurl> <oldurl>`

which translates to:

`git remote set-url origin git@git.hpcloud.net:DevExDocs/apihome.git git@git.hpcloud.net:API-Specs/apihome.git`

If you have any concerns or questions, please contact Rupak Ganguly.

---

# API Strategy - listing, standards and verification

Please visit the [Wiki page](https://wiki.hpcloud.net/display/iaas/API+Strategy+-+Listing%2C+Standards+and+Verification) to see details.

# Publishing 

Please visit [api-publish](https://git.hpcloud.net/API-Specs/api-publish) project that showcases the publishing workflow for the API Specifications. 
This is a work in progress and currently experimental in nature. 

# Markdown Syntax

Use [Markdown Basic](http://daringfireball.net/projects/markdown/syntax) and [Markdown Extra](http://michelf.ca/projects/php-markdown/extra/) formatting syntax.
Some rules while writing the docs:

* The document needs to start with a single top header, and then rest of the document should have headers from 2nd level onwards.
* No HTML characters allowed in the document. So all &lt; and &gt; need to be < and >. No <p> tags etc.
* Code blocks need to be 4 spaces (or 1 tab) indented like so:
    <some xml code fragment>
    {
      some: json
      code: fragment
    }
* Tables needs to be formatted like so:

```
| Header1 | Header2       | Header3 |
| :------ | :------------ | :------ |
| Value 1 | [Value 2]((#link_1)       | Value 3 |
| Value 1 | [Value 2]((#link_1)       | Value 3 |
| Value 1 | [Value 2]((#link_1)       | Value 3 |
```

* No links to internal wiki pages are allowed and needs to be removed.
* Anchors needs to be (#anchor_text_here) instead of the HTML `<a id="anchor_text_here"></a>` style.

# Markdown Editors

The following free editors are recommended and use Live Preview:

* [Mou](http://mouapp.com) for MacOSX Only. Supports tables.
* [MarkdownPad](http://markdownpad.com) for Windows Only. Does not support tables.

The following paid editors are good as well:

* [Marked](http://markedapp.com) for MacOSX Only. Supports tables.

# Markdown Resources

* [Mastering Markdown](http://designshack.net/articles/html/mastering-markdown-30-resources-apps-and-tutorials-to-get-you-started/) - Tutorials and Resources
* [Markdown Syntax](http://daringfireball.net/projects/markdown/syntax)
