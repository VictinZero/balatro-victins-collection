-- TODO:
-- 1. memorize depth of traversed nodes; helpful for large graphs but also
--      hands like starting at 2, 3, 4, and 5, then A in that order;
-- 2. avoid repetitions in the union of next_nodes and aux;

-- Table to store ranks found in the hand
local ranks_found = {}

-- Iterate through each card in the hand and group them by rank
for _, card in ipairs(hand) do
    local cards_found = ranks_found[card.rank] or {}
    cards_found[#cards_found + 1] = card
    ranks_found[card.rank] = cards_found
end

-- Maximum depth for the DFS traversal
local max_depth = 5

-- Perform DFS for each rank found in the hand
for rank in pairs(ranks_found) do
    local depth = DFS(ranks_found, rank, 1, max_depth)
    if depth >= max_depth then
        return true
    end
end

-- Performs a Depth-First Search (DFS) on a graph up to a specified depth.
-- @param graph A table representing the graph where keys are nodes and values are instances of nodes.
-- @param node The current node being visited in the DFS.
-- @param depth The current depth of the DFS traversal.
-- @param max_depth The maximum depth to traverse in the DFS.
-- @return The depth reached during the DFS traversal.
function DFS(graph, node, depth, max_depth)
    if depth >= max_depth then
        return depth
    end

    local max_reached_depth = depth
    local next_nodes = getNextNodes(node)
    for _, next_node in ipairs(next_nodes) do
        if graph[next_node] then
            local reached_depth = DFS(graph, next_node, depth + 1, max_depth)
            if reached_depth > max_reached_depth then
                max_reached_depth = reached_depth
            end
        end
    end

    return max_reached_depth
end

-- Retrieves the next nodes connected to the current node.
-- @param node The current node.
-- @return A table containing the next nodes connected to the current node.
function getNextNodes(node)
    local next_nodes = node.next()
    local aux = {}
    if FourFingers then
        for _, nn in ipairs(next_nodes) do
            local sub_nodes = getNextNodes(nn)
            for _, sub_node in ipairs(sub_nodes) do
                aux[#aux + 1] = sub_node
            end
        end
    end

    -- Compute the union of next_nodes and aux
    local union = {}
    for _, n in ipairs(next_nodes) do
        union[#union + 1] = n
    end
    for _, a in ipairs(aux) do
        union[#union + 1] = a
    end

    return union
end
