
## Error Object삭제(Namespace 삭제 시 행 걸릴 경우)
for i in $(kubectl api-resources --namespaced | awk '{ print $1 }' 2>&1 | grep -v error | tail -n +2 | grep -v persistent ) ; do kubectl delete $i --all ; done
