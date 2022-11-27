const start = [0,0]

const points = [
    {
        name: 'A', 
        coordinates: [34, 50]
    },
    {
        name: 'B', 
        coordinates: [10, 100]
    },
    {
        name: 'C', 
        coordinates: [17, 17]
    },
    {
        name: 'D', 
        coordinates: [74, 120]
    },
    {
        name: 'E',
        coordinates: [-22, 49]
    }
]

function permutator(inputArr) {
    var results = [];
  
    function permute(arr, memo) {
      var cur, memo = memo || [];
  
      for (var i = 0; i < arr.length; i++) {
        cur = arr.splice(i, 1);
        if (arr.length === 0) {
          results.push(memo.concat(cur));
        }
        permute(arr.slice(), memo.concat(cur));
        arr.splice(i, 0, cur[0]);
      }
  
      return results;
    }
  
    return permute(inputArr);
}

function getAllCombinations(points) {
    const allPoints = points.reduce((acc, current) => {
        acc.push(current.name)
        return acc
    }, [])
    return permutator(allPoints)

}

function getAllDistances(points) {
    let allDistances = []
    points.map(p => {
        allDistances[p.name]=[]
        points.map(d => {
            if(p.name === d.name) return
            allDistances[p.name][d.name] = getDistance(p.coordinates[0], p.coordinates[1], d.coordinates[0], d.coordinates[1])
        })
    })
    return allDistances
}

function getAllCombinationsConsts (allCombinations, allDistances) {
    return allCombinations.map(c => {
        let distance = 0;
        const poitCord = points.find(p => p.name === c[0]).coordinates
        for (let i = 0; i < c.length - 2; i++) {
            distance += allDistances[c[i]][c[i+1]]
        }
        return distance + getDistance(start[0], start[1], poitCord[0], poitCord[1])
       });
}

function fastestRout (start, points) {
   const allDistances =  getAllDistances(points);
   const allCombinations = getAllCombinations(points); 
   const allCombinationsCosts = getAllCombinationsConsts(allCombinations, allDistances);
   const fastestRout = {
    cost: Math.min(...allCombinationsCosts),
    rout: allCombinations[allCombinationsCosts.indexOf(Math.min(...allCombinationsCosts))]
   }
   console.log('Start', start, '\nPoints', points, '\nAlldistances:: ', allDistances, '\nAllcombinations:: ', allCombinations, '\nAllCombinationsCosts:: ', allCombinationsCosts, '\nFastestRout:: ', fastestRout);
   //console.log('Start', start, '\nPoints', points, '\nFastestRout:: ', fastestRout);
}

function getDistance(x1, y1, x2, y2){
    let y = x2 - x1;
    let x = y2 - y1;
    
    return Math.sqrt(x * x + y * y);
}

fastestRout(start, points);