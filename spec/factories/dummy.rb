class Dummy
  diffable_on :f1,
              { f2: [:sub1, :sub2, sub3: [subsub1: :subsubsub1]] },
              many: :assocs
end
