@vcr
Feature: YouTube playlists

@announce-stdout
@announce-stderr
  Scenario: Generate YAML for a YouTube playlist
    Given a file named "_sources/youtube" with:
    """
    https://www.youtube.com/playlist?list=PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/youtube.yaml" should exist
    And the file "_data/youtube.yaml" should contain:
    """
    ---
    - title: Chuck Rainey - Bernard Purdie Project "Love the One Your With...Drink Muddy
        Water"
      id: U23Ezi6q30E
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Godfathers of Groove Bernard "Pretty" Purdie,Grant Green Jr,Ruben Wilson
        March 30-31
      id: _ZbWTg8G6eM
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Pretty Purdie - Good Livin' (Good Lovin')  HQ
      id: zJnnNZk9o0Q
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Hot Popcorn   Bernard Purdie
      id: baQe6MoSAHw
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Red Beans and Rice   Bernard Purdie
      id: NLFP1T1e2BA
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Bernard Purdie - Ad Lib
      id: E9E0WxLbqVA
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Bernard Purdie - Black Purd's Theme
      id: wa-K4LouFVk
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: Bernard "Pretty" Purdie - Heavy Soul Slinger
      id: LatmKZQd7-s
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    - title: 'Bernard "Pretty" Purdie: Funky Grooves in Japan'
      id: P842kq0bnOc
      license: YouTube
      license_url: https://www.youtube.com/static?gl=GB&template=terms
    """
