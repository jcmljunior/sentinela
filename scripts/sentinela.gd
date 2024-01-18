extends Node

var defaults = func() -> Dictionary:
	var crypto: Crypto = Crypto.new()
	var key: CryptoKey = crypto.generate_rsa(4096)
	
	return {
		"encrypt": func(value: String):
			return crypto.encrypt(key, value.to_utf8_buffer()),
			
		"decrypt": func(value: PackedByteArray):
			return crypto.decrypt(key, value),
			
		"verify": func(signature: PackedByteArray, value: String):
			return crypto.verify(HashingContext.HASH_SHA256, value.sha256_buffer(), signature, key),
			
		"sign": func(value: String):
			return crypto.sign(HashingContext.HASH_SHA256, value.sha256_buffer(), key)
	}

func _init():
	defaults = defaults.call()

func get_instance() -> Dictionary:
	return defaults
