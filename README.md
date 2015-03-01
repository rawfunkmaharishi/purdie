[![Build Status](http://img.shields.io/travis/rawfunkmaharishi/purdie.svg?style=flat-square)](https://travis-ci.org/rawfunkmaharishi/purdie)
[![Dependency Status](http://img.shields.io/gemnasium/rawfunkmaharishi/purdie.svg?style=flat-square)](https://gemnasium.com/rawfunkmaharishi/purdie)
[![Coverage Status](http://img.shields.io/coveralls/rawfunkmaharishi/purdie.svg?style=flat-square)](https://coveralls.io/r/rawfunkmaharishi/purdie)
[![Code Climate](http://img.shields.io/codeclimate/github/rawfunkmaharishi/purdie.svg?style=flat-square)](https://codeclimate.com/github/rawfunkmaharishi/purdie)
[![Gem Version](http://img.shields.io/gem/v/purdie.svg?style=flat-square)](https://rubygems.org/gems/purdie)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://rawfunkmaharishi.mit-license.org)
[![Badges](http://img.shields.io/:badges-7/7-ff6799.svg?style=flat-square)](https://github.com/badges/badgerbadgerbadger)

#Purdie

We have music on SoundCloud, photos on Flickr, and videos on Vimeo, and we want to feature them on [http://rawfunkmaharishi.uk/](http://rawfunkmaharishi.uk/). Up until now, this has been managed by curating, by hand (or [very shonky scripts](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/blob/master/flickriser.rb)), [bits](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/blob/master/_data/sounds.yml) [of](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/blob/master/_data/pictures.yml) [YAML](https://github.com/rawfunkmaharishi/rawfunkmaharishi.github.io/blob/master/_data/videos.yml) to feed into Jekyll, but this gets old quickly, especially when you run into things like SoundCloud's decision to only expose the track ID deep inside the embeddable iframe code.

But you know what, It's 2015 and everything has an API, so let's build a robot to do this stuff properly!

##The great metadata shift

Up until now, the Hand-Crafted YAML (which sounds like a thing you may be able to buy at Boxpark) approach has allowed me to be a bit lax with the metadata for our media - some of it's been stored on the various services, some purely in my YAML. In order to make this robot universal, I've had to fill in all the metadata at the places where the files live, which feels like the Right Thing anyway.

###Moving the hacks upstream

Moving the metadata is not 100% foolproof, however: for example, we have photos on [our Flickr account](https://www.flickr.com/photos/rawfunkmaharishi/) which were not taken by us, but by our friend [Kim](http://www.kimberlycabbott.com/). But the Flickr API has no way of knowing this, so I've added a tag to those pictures which looks like `photographer:kim` and then I'm looking for and extracting that in this gem. Similarly, for the SoundCloud music, I'd like to tag them with a recording location but this is not supported, so I'm nailing that straight into the _Description_ field.

Am I going to regret these decisions? Almost certainly.

##Using it

You need to set up a *_sources* directory in your Jekyll project, containing files with one-URL-per-line, like this:

    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    https://soundcloud.com/rawfunkmaharishi/junalbandi-3

and a *.env* with API keys in it, and then you can run

    purdie fetch

and it will dump out YAML files into *_data* ready for Jekyll to consume.

For now, though, please don't. None of my metadata hacks are documented, it's got some very Raw Funk Maharishi-specific lookups nailed into it, the output filenames are hardcoded (so it may well overwrite stuff you care about), there are flickering tests, you'll have a bad time. But soon...

##Why Purdie?

Because Bernard Purdie is [amazing](https://www.youtube.com/watch?v=E9E0WxLbqVA&list=PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV&index=6)
