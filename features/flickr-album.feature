@vcr
Feature: Flickr album

  Scenario: Generate Flickr YAML for an album
    Given a file named "_sources/flickr.csv" with:
    """
    https://www.flickr.com/photos/pikesley/sets/72157649827363868/
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should contain:
    """
    ---
    - title: First planting of the year
      date: '2015-01-11'
      photo_page: https://www.flickr.com/photos/pikesley/16252009191/
      photo_url: https://farm8.staticflickr.com/7506/16252009191_ea2d06e6bb_m.jpg
      license: Attribution-NonCommercial-ShareAlike
      license_url: https://creativecommons.org/licenses/by-nc-sa/2.0/
      photographer: sam
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
