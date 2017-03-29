var initSearch = function() {
    var lunrIndex = null;
    var lunrData = null;

    var makeSearch = function(callback) {
        var query = $('.ui.search input').val();
        var results = _(lunrIndex.search(query)).take(5).map(function(object) {
            entry = lunrData.docs[object.ref];
            entry["description"] = entry.tags;
            return entry;
        });
        
        callback({
            results: results
        });
    };

    var loadData = function(callback) {
        $.ajax({
            url: '/search.json',
            cache: true,
            method: 'GET',
            success: function(data) {
                lunrData = data;
                lunrIndex = lunr.Index.load(lunrData.index);
                makeSearch(callback);            
            }
        });
    };

    var executeSearch = function(settings, callback) {
        if (lunrData == null) {
            loadData(callback);
        } else {
            makeSearch(callback);
        }
    };

    $('.ui.search').search({
        template  : 'standard',
        searchFields   : [
            'title',
            'tags'
        ],
        selectFirstResult: true,
        minCharacters: 2,
        maxResults: 5,
        apiSettings: {
            mockResponseAsync: executeSearch
        }
    });   

    loadData(function(){});
};

$(document).ready(initSearch);
$(document).on('turbolinks:load', initSearch);
