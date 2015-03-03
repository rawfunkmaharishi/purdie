@vcr
Feature: Purdie

  Scenario: Generate several YAML
    Given a file named "_sources/sources.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
    https://soundcloud.com/rawfunkmaharishi/junalbandi-3
    https://vimeo.com/111356018
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/soundcloud.yaml" should exist
    And the file "_data/soundcloud.yaml" should contain:
    """
    - title: Hexaflexagon
      id: 193008299
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    - title: Junalbandi
      id: 193005357
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    """
    And a file named "_data/flickr.yaml" should exist
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
    And a file named "_data/vimeo.yaml" should exist
    And the file "_data/vimeo.yaml" should contain:
    """
    ---
    - title: Safety On Board
      id: 111356018
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    """
