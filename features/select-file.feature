@wtf
@vcr
Feature: Select a file to process

  Scenario: Choose file to process
    Given a file named "_sources/soundcloud.source" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    And a file named "_sources/flickr.source" with:
    """
    https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
    """
    When I successfully run `purdie fetch -f _sources/soundcloud.source`
    Then a file named "_data/soundcloud.yaml" should exist
    And the file "_data/soundcloud.yaml" should contain:
    """
    - title: Hexaflexagon
      id: 193008299
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    """
    And a file named "_data/flickr.yaml" should not exist
