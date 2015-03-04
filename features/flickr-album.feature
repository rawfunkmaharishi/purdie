@vcr
Feature: Flickr album

  Scenario: Generate Flickr YAML for an album
    Given a file named "_sources/flickr" with:
    """
    https://www.flickr.com/photos/pikesley/sets/72157649827363868/
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/flickr.yaml" should exist
    And the file "_data/flickr.yaml" should not contain:
    """
    The Comedy
    """
    And a file named "_data/soundcloud.yaml" should not exist
    And a file named "_data/vimeo.yaml" should not exist
