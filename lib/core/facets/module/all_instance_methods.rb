class Module

  # List all instance methods, equivalent to
  #
  #   public_instance_methods +
  #   protected_instance_methods +
  #   private_instance_methods
  #
  # TODO: Better name for #all_instance_methods?
  #
  # CREDIT: Trans

  def all_instance_methods(include_super=true)
    public_instance_methods(include_super) +
    protected_instance_methods(include_super) +
    private_instance_methods(include_super)
  end

end
