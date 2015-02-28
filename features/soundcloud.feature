@vcr
Feature: Soundcloud

  Scenario: Generate SoundCloud YAML
    Given a file named "_sources/sounds.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/sounds.yaml" should exist
    And the file "_data/sounds.yaml" should contain:
    """
    - title: Hexaflexagon
      id: 193008299
      location: Islington Academy
      date: '2015-02-18'
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
    """


  Scenario: Generate SoundCloud YAML for multiple tracks
    Given a file named "_sources/sounds.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    https://soundcloud.com/rawfunkmaharishi/junalbandi-3
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/sounds.yaml" should exist
    And the file "_data/sounds.yaml" should contain:
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
