class Timer{
	IntList keys;
	String name;
	int size(){
		return keys.size();
	}
	int getPosInd(int ind){
		for(int i = 0; i < keys.size(); i++){
			if(ind ==  keys.get(i)){
				return i;
			}
		}
		return -1;
	}
	String getStringValue(int frame){
		return "nonee";
	}
	void remove(int ind){}
	void moveKey(int ind, int nind){}
	JSONObject getJson(){
		return null;
	}
	void setJson(JSONObject jo){
	}
};

class BooleanTimer extends Timer{
	HashMap<Integer, Boolean> values;
	BooleanTimer(String name){
		this.name = name;
		values = new HashMap<Integer, Boolean>();
		keys = new IntList();
		add(0, true);
	}
	BooleanTimer(String name, boolean value){
		this.name = name;
		values = new HashMap<Integer, Boolean>();
		keys = new IntList();
		add(0, value);
	}
	void add(int ind, boolean value){
		remove(ind);
		values.put(ind, value);
		keys.append(ind);
		keys.sort();
	}
	void remove(int ind){
		values.remove(ind);
		int ri = getPosInd(ind);
		if(ri != -1)keys.remove(ri);
	}
	void moveKey(int ind, int nind){
		boolean value = values.get(ind);
		remove(ind);
		add(nind, value);
	}
	boolean getValue(int frame){
		boolean value = false;
		if(keys.get(0) > frame){
			value = values.get(keys.get(0));
		}else if (keys.get(keys.size()-1) < frame){
			value = values.get((keys.get(keys.size()-1)));
		}else if(values.containsKey(frame)){
			value = values.get(frame);
		}else{
			int prev = keys.get(0); 
			for(int i = 1; i < keys.size(); i++){
				if(keys.get(i) > frame){
					break; 
				}
				prev = keys.get(i);
			}
			value = values.get(prev);
		}
		return value;
	}

	String getStringValue(int frame){
		return str(getValue(frame));
	}
	JSONObject getJson(){
		JSONObject aux = new JSONObject();
		aux.setString("type", "boolean");
		JSONArray jkeys = new JSONArray();
		for(int i = 0; i < keys.size(); i++){
			JSONObject key = new JSONObject();
			int frame = keys.get(i);
			key.setInt("time", frame);
			key.setBoolean("value", getValue(frame));
			jkeys.setJSONObject(i, key);
		}
		aux.setJSONArray("keys", jkeys);
		return aux;
	}
};

class FloatTimer extends Timer{
	Float min, max;
	HashMap<Integer, Float> values;
	FloatTimer(String name){
		this.name = name;
		values = new HashMap<Integer, Float>();
		keys = new IntList();
		add(0, 0);
	}
	FloatTimer(String name, float value){
		this.name = name;
		values = new HashMap<Integer, Float>();
		keys = new IntList();
		add(0, value);
	}
	void add(int ind, float value){
		if(min != null && value < min) value = min;
		if(max != null && value > max) value = max;
		remove(ind);
		values.put(ind, value);
		keys.append(ind);
		keys.sort();
	}
	void remove(int ind){
		values.remove(ind);
		int ri = getPosInd(ind);
		if(ri != -1)keys.remove(ri);
	}
	void moveKey(int ind, int nind){
		float value = values.get(ind);
		remove(ind);
		add(nind, value);
	}
	float getValue(int frame){
		float value = 0;
		if(keys.get(0) > frame){
			value = values.get(keys.get(0));
		}else if (keys.get(keys.size()-1) < frame){
			value = values.get((keys.get(keys.size()-1)));
		}else if(values.containsKey(frame)){
			value = values.get(frame);
		}else{
			int prev = keys.get(0); 
			int next = prev;
			for(int i = 1; i < keys.size(); i++){
				next = keys.get(i);
				if(next > frame){
					break;
				}
				prev = next;
			}
			value = map(frame, prev, next, values.get(prev), values.get(next));
		}
		return value;
	}
	String getStringValue(int frame){
		return str(getValue(frame));
	}
	void setMin(float min){
		this.min = min;
	}
	void setMax(float max){
		this.max = max;
	}


	JSONObject getJson(){
		JSONObject aux = new JSONObject();
		aux.setString("type", "float");
		JSONArray jkeys = new JSONArray();
		for(int i = 0; i < keys.size(); i++){
			JSONObject key = new JSONObject();
			int frame = keys.get(i);
			key.setInt("time", frame);
			key.setFloat("value", getValue(frame));
			jkeys.setJSONObject(i, key);
		}
		aux.setJSONArray("keys", jkeys);
		return aux;
	}
};

class IntegerTimer extends Timer{
	Integer min, max;
	HashMap<Integer, Integer> values;
	IntegerTimer(String name){
		this.name = name;
		values = new HashMap<Integer, Integer>();
		keys = new IntList();
		add(0, 0);
	}
	IntegerTimer(String name, int value){
		this.name = name;
		values = new HashMap<Integer, Integer>();
		keys = new IntList();
		add(0, value);
	}
	void add(int ind, int value){
		if(min != null && value < min) value = min;
		if(max != null && value > max) value = max;
		remove(ind);
		values.put(ind, value);
		keys.append(ind);
		keys.sort();
	}

	void remove(int ind){
		values.remove(ind);
		int ri = getPosInd(ind);
		if(ri != -1)keys.remove(ri);
	}
	void moveKey(int ind, int nind){
		int value = values.get(ind);
		remove(ind);
		add(nind, value);
	}
	int getValue(int frame){
		int value = 20;
		if(keys.get(0) > frame){
			value = values.get(keys.get(0));
		}else if (keys.get(keys.size()-1) < frame){
			value = values.get((keys.get(keys.size()-1)));
		}else if(values.containsKey(frame)){
			value = values.get(frame);
		}else{
			int prev = keys.get(0); 
			int next = prev;
			for(int i = 1; i < keys.size(); i++){
				next = keys.get(i);
				if(next > frame){
					break;
				}
				prev = next;
			}
			value = int(map(frame, prev, next, values.get(prev), values.get(next)));
		}
		return value;
	}
	String getStringValue(int frame){
		return str(getValue(frame));
	}
	void setMin(int min){
		this.min = min;
	}
	void setMax(int max){
		this.max = max;
	}

	JSONObject getJson(){
		JSONObject aux = new JSONObject();
		aux.setString("type", "integer");
		JSONArray jkeys = new JSONArray();
		for(int i = 0; i < keys.size(); i++){
			JSONObject key = new JSONObject();
			int frame = keys.get(i);
			key.setInt("time", frame);
			key.setInt("value", getValue(frame));
			jkeys.setJSONObject(i, key);
		}
		aux.setJSONArray("keys", jkeys);
		return aux;
	}
}