
for file in *.scm; do
  mv "$file" "${file%.scm}.rkt"
done

