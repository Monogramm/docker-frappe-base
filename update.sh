#!/bin/bash
set -eo pipefail

declare -A versions=(
	[debian]='stretch stretch-slim jessie jessie-slim'
	[alpine]='3.8 3.9'
)

declare -A base=(
	[debian]='debian'
	[alpine]='alpine'
)

variants=(
	debian
	alpine
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
	IFS=', ' read -r -a varVersions <<< "${versions[$variant]}"

	for version in "${varVersions[@]}"; do
		# Create the variant directory with a Dockerfile.
		dir="images/$variant/$version"
		if [ -d "$dir" ]; then
			continue
		fi
		echo "generating $variant [$version]"
		mkdir -p "$dir"

		shortVersion=${version/-slim/}

		template="Dockerfile-${base[$variant]}.template"
		cp "$template" "$dir/Dockerfile"

		# Replace the variables.
		sed -ri -e '
			s/%%VARIANT%%/'"$variant"'/g;
			s/%%VERSION%%/'"$version"'/g;
			s/%%SHORT_VERSION%%/'"$shortVersion"'/g;
		' "$dir/Dockerfile"

		# Copy the shell scripts
		#for name in entrypoint; do
		#	cp "docker-$name.sh" "$dir/$name.sh"
		#	chmod 755 "$dir/$name.sh"
		#done

		cp ".dockerignore" "$dir/.dockerignore"

		travisEnv='\n    - VARIANT='"$variant"' VERSION='"$version$travisEnv"

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
