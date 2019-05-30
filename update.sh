#!/bin/bash
set -eo pipefail

declare -A base=(
	[stretch]='debian'
	[slim-stretch]='debian'
	[alpine]='alpine'
)

variants=(
	stretch
	slim-stretch
	alpine
)

versions=(
	3.8-rc
	3.7
	3.6
	3.5
	2.7
)


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-frappe-base"

# Remove existing images
echo "reset docker images"
rm -rf ./images/
mkdir -p ./images/

echo "update docker images"
travisEnv=
for variant in "${variants[@]}"; do

	for version in "${versions[@]}"; do
		# Create the variant directory with a Dockerfile.
		dir="images/$version/$variant"
		if [ -d "$dir" ]; then
			continue
		fi
		echo "generating $version [$variant]"
		mkdir -p "$dir"

		shortVariant=${variant/slim-/}
		majorVersion=${version:0:1}
		if [[ "$majorVersion" = "2" && "${base[$variant]}" = "debian" ]]; then
			majorVersion=
		fi

		template="Dockerfile-${base[$variant]}.template"
		cp "$template" "$dir/Dockerfile"

		# Replace the variables.
		sed -ri -e '
			s/%%VARIANT%%/'"$variant"'/g;
			s/%%VERSION%%/'"$version"'/g;
			s/%%MAJOR_VERSION%%/'"$majorVersion"'/g;
			s/%%SHORT_VARIANT%%/'"$shortVariant"'/g;
		' "$dir/Dockerfile"

		# Copy the shell scripts
		#for name in entrypoint; do
		#	cp "docker-$name.sh" "$dir/$name.sh"
		#	chmod 755 "$dir/$name.sh"
		#done

		cp ".dockerignore" "$dir/.dockerignore"

		travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

		if [[ $1 == 'build' ]]; then
			tag="$variant-$version"
			echo "Build Dockerfile for ${tag}"
			docker build -t ${dockerRepo}:${tag} $dir
		fi
	done

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
