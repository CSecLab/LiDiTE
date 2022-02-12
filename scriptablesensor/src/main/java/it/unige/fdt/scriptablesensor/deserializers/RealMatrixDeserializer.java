package it.unige.fdt.scriptablesensor.deserializers;

import java.io.IOException;

import org.apache.commons.math3.linear.BlockRealMatrix;
import org.apache.commons.math3.linear.RealMatrix;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;

public class RealMatrixDeserializer extends JsonDeserializer<RealMatrix> {

    @Override
    public RealMatrix deserialize(JsonParser p, DeserializationContext ctxt)
	    throws IOException, JsonProcessingException {
	JsonNode tree = p.getCodec().readTree(p);
	if (tree.isNumber()) {
	    // Scalar value
	    RealMatrix m = new BlockRealMatrix(1, 1);
	    m.setEntry(0, 0, tree.asDouble());
	    return m;
	} else if (tree.isArray()) {
	    // Matrix
	    ArrayNode array = (ArrayNode) tree;
	    int rows = array.size();
	    int cols = array.get(0).size();
	    RealMatrix m = new BlockRealMatrix(rows, cols);
	    for (int i = 0; i < rows; i++) {
		ArrayNode row = (ArrayNode) array.get(i);
		for (int j = 0; j < cols; j++) {
		    m.setEntry(i, j, row.get(j).asDouble());
		}
	    }
	    return m;
	} else {
	    throw new IllegalArgumentException();
	}
    }

}
