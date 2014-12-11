#
# Cookbook Name:: nginx
# Attributes:: source
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012-2013, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_attribute 'nginx::default'

default['nginx']['source']['version']                 = node['nginx']['version']
default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"
default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
)

default['nginx']['configure_flags']    = []
default['nginx']['source']['version']  = node['nginx']['version']
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['checksum'] = '0510af71adac4b90484ac8caf3b8bd519a0f7126250c2799554d7a751a2db388'
default['nginx']['source']['modules']  = %w(
  nginx::http_ssl_module
  nginx::http_gzip_static_module
)
default['nginx']['source']['use_existing_user'] = false

default['nginx']['gpg_fingerprint'] = "B0F4 2533 73F8 F6F5 10D4  2178 520A 9993 A1C0 52F8"
default['nginx']['gpg_key']    = 
"-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mQENBE7SKu8BCADQo6x4ZQfAcPlJMLmL8zBEBUS6GyKMMMDtrTh3Yaq481HB54oR
0cpKL05Ff9upjrIzLD5TJUCzYYM9GQOhguDUP8+ZU9JpSz3yO2TvH7WBbUZ8FADf
hblmmUBLNgOWgLo3W+FYhl3mz1GFS2Fvid6Tfn02L8CBAj7jxbjL1Qj/OA/WmLLc
m6BMTqI7IBlYW2vyIOIHasISGiAwZfp0ucMeXXvTtt14LGa8qXVcFnJTdwbf03AS
ljhYrQnKnpl3VpDAoQt8C68YCwjaNJW59hKqWB+XeIJ9CW98+EOAxLAFszSyGanp
rCqPd0numj9TIddjcRkTA/ZbmCWK+xjpVBGXABEBAAG0IU1heGltIERvdW5pbiA8
bWRvdW5pbkBtZG91bmluLnJ1PohGBBARAgAGBQJO01Y/AAoJEOzw6QssFyCDVyQA
n3qwTZlcZgyyzWu9Cs8gJ0CXREaSAJ92QjGLT9DijTcbB+q9OS/nl16Z/IhGBBAR
AgAGBQJO02JDAAoJEKk3YTmlJMU+P64AnjCKEXFelSVMtgefJk3+vpyt3QX1AKCH
9M3MbTWPeDUL+MpULlfdyfvjj4heBBARCAAGBQJRCTwgAAoJEFGFCWhsfl6CzF0B
AJsQ3DJbtGcZ+0VIcM2a06RRQfBvIHqm1A/1WSYmObLGAP90lxWlNjSugvUUlqTk
YEEgRTGozgixSyMWGJrNwqgMYokBOAQTAQIAIgUCTtIq7wIbAwYLCQgHAwIGFQgC
CQoLBBYCAwECHgECF4AACgkQUgqZk6HAUvj+iwf/b4FS6zVzJ5T0v1vcQGD4ZzXe
D5xMC4BJW414wVMU15rfX7aCdtoCYBNiApPxEd7SwiyxWRhRA9bikUq87JEgmnyV
0iYbHZvCvc1jOkx4WR7E45t1Mi29KBoPaFXA9X5adZkYcOQLDxa2Z8m6LGXnlF6N
tJkxQ8APrjZsdrbDvo3HxU9muPcq49ydzhgwfLwpUs11LYkwB0An9WRPuv3jporZ
/XgI6RfPMZ5NIx+FRRCjn6DnfHboY9rNF6NzrOReJRBhXCi6I+KkHHEnMoyg8XET
9lVkfHTOl81aIZqrAloX3/00TkYWyM2zO9oYpOg6eUFCX/Lw4MJZsTcT5EKVxLkB
DQRO0irvAQgA0LjCc8S6oZzjiap2MjRNhRFA5BYjXZRZBdKF2VP74avt2/RELq8G
W0n7JWmKn6vvrXabEGLyfkCngAhTq9tJ/K7LPx/bmlO5+jboO/1inH2BTtLiHjAX
vicXZk3oaZt2Sotx5mMI3yzpFQRVqZXsi0LpUTPJEh3oS8IdYRjslQh1A7P5hfCZ
wtzwb/hKm8upODe/ITUMuXeWfLuQj/uEU6wMzmfMHb+jlYMWtb+v98aJa2FODeKP
mWCXLa7bliXp1SSeBOEfIgEAmjM6QGlDx5sZhr2Ss2xSPRdZ8DqD7oiRVzmstX1Y
oxEzC0yXfaefC7SgM0nMnaTvYEOYJ9CH3wARAQABiQEfBBgBAgAJBQJO0irvAhsM
AAoJEFIKmZOhwFL4844H/jo8icCcS6eOWvnen7lg0FcCo1fIm4wW3tEmkQdchSHE
CJDq7pgTloN65pwB5tBoT47cyYNZA9eTfJVgRc74q5cexKOYrMC3KuAqWbwqXhkV
s0nkWxnOIidTHSXvBZfDFA4Idwte94Thrzf8Pn8UESudTiqrWoCBXk2UyVsl03gJ
blSJAeJGYPPeo+Yj6m63OWe2+/S2VTgmbPS/RObn0Aeg7yuff0n5+ytEt2KL51gO
QE2uIxTCawHr12PsllPkbqPk/PagIttfEJqn9b0CrqPC3HREePb2aMJ/Ctw/76CO
wn0mtXeIXLCTvBmznXfaMKllsqbsy2nCJ2P2uJjOntw=
=ISka
-----END PGP PUBLIC KEY BLOCK-----"