removed = {}
failed = {}

prunable = {}
prunable["weekly"] = true
prunable["daily"] = true
prunable["hourly"] = true


function is_prunable(ds_name)
	match = string.match(ds_name, "@(%a+)\\-")
	if (not match) then
		return false
	end
	return (prunable[match] ~= nil)
end


function clean_snaps(ds_name)
	for child in zfs.list.children(ds_name) do
		clean_snaps(child)
	end
	for snap in zfs.list.snapshots(ds_name) do
		if (is_prunable(snap)) then
			err = zfs.sync.destroy(snap)
			if (err ~= 0) then
				failed[snap] = err
			else
				removed[snap] = err
			end
		end
	end
end

clean_snaps("zones")

results = {}
results["failed"] = failed
results["removed"] = removed
return results


