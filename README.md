Original
--------
This is the fork of [Pythonic Perambulations](http://jakevdp.github.io)
blog. It is built using the [Pelican](http://blog.getpelican.com/)
blogging platform.

Requirements
------------

- Do this:

  ```
    # prepare
    sudo pip install pelican markdown
    sudo apt-get install pandoc

    # generate content 
    pelican content

    # start server
    cd output
    python -m SimpleHTTPServer
    
    # open up http://localhost:8000
  ```

- Recent version of [IPython](http://github.com/ipython/ipython).  The
  liquid_tags plugin above requires IPython 1.0.  Note that previously
  this could be built with the stand-alone nbconvert package.  That
  no longer works with the recent liquid_tags plugin.

- Recent version of [Pelican](http://github.com/getpelican/pelican).  For
  the static paths (downloads, images, figures, etc.) to appear in the right
  place, Pelican 3.3+ must be used.