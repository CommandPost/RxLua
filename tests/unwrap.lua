describe('unwrap', function()
  it('produces an error if its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:unwrap().subscribe).to.fail()
  end)

  it('produces any multiple values as individual values', function()
    local observable = Rx.Observable.create(function(observer)
      observer:onNext(1)
      observer:onNext(2, 3)
      observer:onNext(4, 5, 6)
      observer:onComplete()
    end)
    expect(observable).to.produce({{1}, {2, 3}, {4, 5, 6}})
    expect(observable:unwrap()).to.produce(1, 2, 3, 4, 5, 6)
  end)
end)
