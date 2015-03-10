@vcr
Feature: Set Flickr picturesize

  Scenario: Generate Flickr YAML
    Given a file named "_sources/flickr.csv" with:
    """
    https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
    """
    And a file named "_config/purdie.yaml" with:
    """
    services:
      Flickr:
        size: 700
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should contain:
    """
    - title: The Comedy, October 2014
      date: '2014-10-22'
      photo_page: https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
      photo_url: https://farm4.staticflickr.com/3933/15631479625_b6168ee903_c.jpg
      license: Attribution-NonCommercial-ShareAlike
      license_url: https://creativecommons.org/licenses/by-nc-sa/2.0/
      photographer: kim
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
