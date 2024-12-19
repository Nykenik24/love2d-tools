local math = {
    -- General Mathematical Functions
    --- Restricts a value to the specified range.
    --- @param value number: The value to clamp.
    --- @param min number: The lower bound.
    --- @param max number: The upper bound.
    --- @return number: The clamped value.
    clamp = function(value, min, max)
        return math.max(min, math.min(max, value))
    end,

    --- Linearly interpolates between two values.
    --- @param a number: The starting value.
    --- @param b number: The ending value.
    --- @param t number: The interpolation factor (0 to 1).
    --- @return number: The interpolated value.
    lerp = function(a, b, t)
        return a + (b - a) * t
    end,

    --- Smoothly interpolates between two values using a cubic curve.
    --- @param edge0 number: The lower edge of the transition.
    --- @param edge1 number: The upper edge of the transition.
    --- @param x number: The input value.
    --- @return number: The smoothed value.
    smoothstep = function(edge0, edge1, x)
        local clamp = math.clamp
        x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
        return x * x * (3 - 2 * x)
    end,

    --- Wraps a value within a specified range.
    --- @param value number: The value to wrap.
    --- @param min number: The lower bound.
    --- @param max number: The upper bound.
    --- @return number: The wrapped value.
    wrap = function(value, min, max)
        return min + ((value - min) % (max - min))
    end,

    -- Vector and Geometry Functions
    --- Calculates the distance between two points.
    --- @param x1 number: The x-coordinate of the first point.
    --- @param y1 number: The y-coordinate of the first point.
    --- @param x2 number: The x-coordinate of the second point.
    --- @param y2 number: The y-coordinate of the second point.
    --- @return number: The distance between the points.
    distance = function(x1, y1, x2, y2)
        return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    end,

    --- Calculates the angle between two points in radians.
    --- @param x1 number: The x-coordinate of the first point.
    --- @param y1 number: The y-coordinate of the first point.
    --- @param x2 number: The x-coordinate of the second point.
    --- @param y2 number: The y-coordinate of the second point.
    --- @return number: The angle in radians.
    angleBetweenPoints = function(x1, y1, x2, y2)
        return math.atan2(y2 - y1, x2 - x1)
    end,

    --- Calculates the magnitude of a vector.
    --- @param x number: The x-component of the vector.
    --- @param y number: The y-component of the vector.
    --- @return number: The magnitude of the vector.
    vectorMagnitude = function(x, y)
        return math.sqrt(x^2 + y^2)
    end,

    --- Normalizes a vector to a unit vector.
    --- @param x number: The x-component of the vector.
    --- @param y number: The y-component of the vector.
    --- @return number, number: The normalized x and y components.
    normalizeVector = function(x, y)
        local mag = math.vectorMagnitude(x, y)
        if mag == 0 then return 0, 0 end
        return x / mag, y / mag
    end,

    --- Calculates the dot product of two vectors.
    --- @param x1 number: The x-component of the first vector.
    --- @param y1 number: The y-component of the first vector.
    --- @param x2 number: The x-component of the second vector.
    --- @param y2 number: The y-component of the second vector.
    --- @return number: The dot product.
    dotProduct = function(x1, y1, x2, y2)
        return x1 * x2 + y1 * y2
    end,

    --- Calculates the cross product magnitude of two 2D vectors.
    --- @param x1 number: The x-component of the first vector.
    --- @param y1 number: The y-component of the first vector.
    --- @param x2 number: The x-component of the second vector.
    --- @param y2 number: The y-component of the second vector.
    --- @return number: The cross product magnitude.
    crossProduct = function(x1, y1, x2, y2)
        return x1 * y2 - y1 * x2
    end,

    -- Probability and Randomization
    --- Generates a random float in a specified range.
    --- @param min number: The minimum value.
    --- @param max number: The maximum value.
    --- @return number: The random float.
    randomFloat = function(min, max)
        return min + (max - min) * math.random()
    end,

    --- Selects a random index based on weighted probabilities.
    --- @param weights table: A table of weights.
    --- @return number: The selected index.
    weightedRandom = function(weights)
        local total = 0
        for _, weight in ipairs(weights) do total = total + weight end
        local rnd = math.random() * total
        for i, weight in ipairs(weights) do
            rnd = rnd - weight
            if rnd <= 0 then return i end
        end
    end,

    -- Advanced Math
    --- Calculates the modulo with proper handling for negative numbers.
    --- @param a number: The dividend.
    --- @param b number: The divisor.
    --- @return number: The modulo result.
    mod = function(a, b)
        return (a % b + b) % b
    end,

    --- Converts polar coordinates to Cartesian coordinates.
    --- @param angle number: The angle in radians.
    --- @param radius number: The radius.
    --- @return number, number: The x and y coordinates.
    polarToCartesian = function(angle, radius)
        return radius * math.cos(angle), radius * math.sin(angle)
    end,

    --- Converts Cartesian coordinates to polar coordinates.
    --- @param x number: The x-coordinate.
    --- @param y number: The y-coordinate.
    --- @return number, number: The angle in radians and the radius.
    cartesianToPolar = function(x, y)
        return math.atan2(y, x), math.vectorMagnitude(x, y)
    end
}

return math
