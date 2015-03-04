@vcr
Feature: A URL we don't understand

  Scenario: Handle a URL we don't recognise
    Given a file named "_sources/flickr.csv" with:
    """
    https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
    https://www.madeup.com/foo/bar/
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should contain:
    """
    - title: The Comedy, October 2014
      date: '2014-10-22'
      photo_page: https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
      photo_url: https://farm4.staticflickr.com/3933/15631479625_b6168ee903_m.jpg
      license: Attribution-NonCommercial-ShareAlike
      license_url: https://creativecommons.org/licenses/by-nc-sa/2.0/
      photographer: kim
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
