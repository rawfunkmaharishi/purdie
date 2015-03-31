@wtf
@vcr
Feature: Flickr

  Scenario: Generate Flickr YAML with lookups
    Given a file named "_sources/flickr.csv" with:
    """
    https://www.flickr.com/photos/cluttercup/16393865760/
    """
    And a file named "_config/purdie.yaml" with:
    """
    photographer_lookups:
      cluttercup: jane

    default_title: Raw Funk Maharishi
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should contain:
    """
    - title: Raw Funk Maharishi
      date: '2015-02-18'
      photo_page: https://www.flickr.com/photos/cluttercup/16393865760/
      photo_url: https://farm8.staticflickr.com/7395/16393865760_bfbfc1c267_m.jpg
      license: Attribution-NonCommercial
      license_url: https://creativecommons.org/licenses/by-nc/2.0/
      photographer: jane
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
